From: hejianet@gmail.com (Jia He)
Date: Thu, 21 Sep 2017 16:35:05 +0800
Subject: Possible gcc 4.8.5 bug about RELOC_HIDE marcro
In-Reply-To: <22979.28663.77963.862263@gargle.gargle.HOWL>
References: <03f619bd-e3b2-49e0-5f2c-e232974eac12@gmail.com>
 <22979.28663.77963.862263@gargle.gargle.HOWL>
Message-ID: <c9da3aad-f8c2-4396-a15f-e1a1188590dd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Mikael

It is a known gcc bug, please see 
https://gcc.gnu.org/ml/gcc-patches/2017-03/msg00790.html


Cheers,

Jusitn(Jia He)


? 9/21/2017 3:53 PM, Mikael Pettersson Wrote:
> Jia He writes:
>   > I tried to build kernel 4.14-rc1 on a arm64 server in distro centos 7.3.
>   > The gcc version is 4.8.5
>
> I have no input on the specifics of the issue, but please note that gcc-4.8
> is no longer supported or maintained by upstream.  Even gcc-4.9 is EOL, and
> gcc-5 will be EOL:d inn a week or so.  Also I'll note that gcc-4.8 is still
> fairly early wrt to arm64 support, so bugs may be expected.
>
> In short, please retry with gcc-6.4 or gcc-7.2.
>
