From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 23 Feb 2017 14:58:18 +0100
Subject: [PATCH 1/1] ARM: dts: BCM953012HR: Initial Checkin
In-Reply-To: <CA+Jmh7Ha0CTmTQnexz7oga2m54paKxbqZ+yF5orbEH72Ffi3Ag@mail.gmail.com>
References: <1487798092-8631-1-git-send-email-steven.lin1@broadcom.com>
 <68373798-376d-43d9-85cb-c6af7c6fa302@gmail.com>
 <CA+Jmh7Ha0CTmTQnexz7oga2m54paKxbqZ+yF5orbEH72Ffi3Ag@mail.gmail.com>
Message-ID: <CACna6rwYhM9_5_V+sdczMWoMjcLg7wh_MEJZthCBsj6hH0dQrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2017 at 14:38, Steve Lin <steven.lin1@broadcom.com> wrote:
> * Resending in plaintext - forgot to disable html in my mail client -
> apologies if you receive 2 copies *
>
> Rafal & Rob,
>
> I will spin a v2 with the cleanups Rob suggested and the uart/nand
> changes Rafal suggested.  Thanks!
>
> Rafal, to answer your question about having similar partitions on both
> flash devices, that is something that I believe we do on our reference
> platforms to demonstrate to customers using either flash for storing
> their kernel image, rootfs, etc.  See for example bcm958625k.dts where
> we also have similar partition names for nand and spi flash.

OK, thanks!

-- 
Rafa?
