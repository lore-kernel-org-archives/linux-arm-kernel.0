From: songjun.wu@atmel.com (Wu, Songjun)
Date: Mon, 4 Jul 2016 11:04:16 +0800
Subject: [PATCH v5 0/2] [media] atmel-isc: add driver for Atmel ISC
In-Reply-To: <e96fe150-2e5c-5ffa-3c1b-99e55fa4bff0@xs4all.nl>
References: <1466153854-30272-1-git-send-email-songjun.wu@atmel.com>
 <e96fe150-2e5c-5ffa-3c1b-99e55fa4bff0@xs4all.nl>
Message-ID: <8aaf895f-d600-7df6-fcb4-3c3e366c0b90@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/1/2016 20:20, Hans Verkuil wrote:
> Hi Songjun,
>
> First of all, please CC patch 2/2 to linux-media as well the next time you post this.
> I only see 1/2 on the mailinglist, and we need both.
>
> Secondly, before I can accept it you need to run the v4l2-compliance test first and
> I need to see the output of that test.
>
> The compliance test is here: https://git.linuxtv.org/v4l-utils.git. Always compile it from
> the repository so you know you are using the latest most up to date version.
>
> Since this driver supports multiple pixelformats you need to test with the -f option,
> which tests streaming for all pixelformats.
>
> Obviously, there shouldn't be any FAILs :-)
>
> I greatly simplifies the code review if I know it passes the compliance test.
>
Hi Hans,

You suggestion is very helpful to me.
I will give the output of the compliance test in next version.

> Regards,
>
> 	Hans
>
