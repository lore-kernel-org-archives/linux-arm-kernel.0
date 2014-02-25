From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 16:59:21 +0100
Subject: [PATCH 0/2] ARM: SAMSUNG: move all arches to generic uncompress.h
In-Reply-To: <CAK9yfHycc-98YG1ZWD5sB=k8t4CCYmxfRoJxSR_v=Hdm8FPG8g@mail.gmail.com>
References: <3594365.ORKU4Q2jDp@phil> <3158811.UU2ZyPShVi@phil>
 <CAK9yfHycc-98YG1ZWD5sB=k8t4CCYmxfRoJxSR_v=Hdm8FPG8g@mail.gmail.com>
Message-ID: <2577208.cj79hmXajC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 25. Februar 2014, 21:11:09 schrieb Sachin Kamat:
>  Hi Heiko,
> 
> On 25 February 2014 19:47, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Sonntag, 16. Februar 2014, 18:32:24 schrieb Heiko St?bner:
> >> On 2014-01-06 Sachin Kamat posted two patches converting Exynos to use
> >> the generic uncompress.h.
> >> 
> >> But in fact all Samsung platforms can go this route, as all Samsung
> >> uncompress.h files are simply used to set up the serial port.
> >> 
> >> As the original patches were not yet applied, this series includes the
> >> original Exynos-specific change.
> >> 
> >> Tested on a s3c2416 and s3c2442 based machine.
> > 
> > ping?
> 
> Kukjin has already applied my 2 patches doing this for Exynos.
> You might need to rebase your patches on top of his for-next and re-send.

now I've seen that he applied them yesterday ... will rebase mine as 
suggested.


Heiko
