From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 21 Oct 2015 14:09:42 +0900
Subject: Which is better to specify console, "console= " or "stdout-path" ?
Message-ID: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


I think there exist two ways to specify the console port and baudrate.


[1] Specify console in bootargs

  chosen {
        bootargs = "console=ttyS0,115200";
  };


[2] Specify stdout-path

   chosen {
         stdout-path = "serial0:115200n8";
   };



Now I have both in my DTS, but it is redundant.

So, I want to select either [1] or [2].


Which is a preferable way?


Thanks,



-- 
Best Regards
Masahiro Yamada
