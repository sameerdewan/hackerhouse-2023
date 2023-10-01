import Image from 'next/image'
import Navbar from './component/Navbar';

export default function Home() {
  return (
    <main className="w-full flex flex-col items-center gap-10">
     <div className="flex justify-center w-full">
      <Navbar />
     </div>
    </main>
  )
}

type CardProps = {
  title: string;
  body: string;
  href: string;
  icon: string;
  width: number;
}

const Card = ({ title, width, body, href, icon }: CardProps) => {
  return (
    <li className="list-none">
      <a href={href} className="h-full flex flex-col no-underline rounded-3xl border-[0.85px] border-[#313538] gap-[15px] px-8 py-5">
        <div className="flex gap-[15px] items-start ">
          <Image
            alt="card-icon"
            src={icon}
            height={31}
            width={width}
          />
          <h2 className="text-xl font-bold leading-8 m-0 text-white">
            {title}
          </h2>
        </div>
        <p className="text-md leading-6 text-[#9ca3af]">
          {body}
        </p>
      </a>
    </li>
  )
}
