From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 14:44:59 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAD=FV=U6HuQj3MxZ-yF-MYdjzqjT5bu=K26JuHZP1hjJzkSqbg@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <CAM4voa=1FY5bfk095BU=3X=vzqjnCSfdLoXpCix5tOwDgOoioQ@mail.gmail.com>
 <CAD=FV=UwgPQVm_KvHbpoJNs-5EtpyaYJ2rp2f-466uhnob=ixA@mail.gmail.com>
 <CAM4voa=cTbobQHi+sBOCy_CDYAnQ6CsvvuoE7XwqFZV_E3gEbQ@mail.gmail.com>
 <CAD=FV=U6HuQj3MxZ-yF-MYdjzqjT5bu=K26JuHZP1hjJzkSqbg@mail.gmail.com>
Message-ID: <CAD=FV=Xbu6hV66Eewev2261xoSrtqj22fXYf1VXyin=WBcDerQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 6, 2014 at 1:49 PM, Doug Anderson <dianders@google.com> wrote:
>> Are you talking about the re-writing the mcpm entry point address post-resume ?
>
> Or even (as Andrew points out) just don't use it.
>
> This works and IMHO is much cleaner because it totally removes the
> U-Boot dependency.  I'll cleanup to not be so insane and post:

The less insane version is at
<https://patchwork.kernel.org/patch/4313611/>.  Thanks to Andrew for
the suggestion!

-Doug
