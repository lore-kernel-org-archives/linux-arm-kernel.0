From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sun, 06 Jul 2014 14:30:54 -0300
Subject: [PATCH v2 10/8] ARM: sun7i: cubietruck: add an SPIdev device
 for testing
In-Reply-To: <53B96978.4060001@cogentembedded.com>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-11-git-send-email-emilio@elopez.com.ar>
 <53B96978.4060001@cogentembedded.com>
Message-ID: <53B987CE.2030307@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 06/07/14 12:21, Sergei Shtylyov escribi?:
> Hello.
>
> On 07/06/2014 08:05 AM, Emilio L?pez wrote:
>
>     You need to sign off on your patches, else they couldn't be applied.

That's kind of the point here. These patches are just intended for 
testing. From the cover letter:

"""Patches nine, ten and eleven are *only intended
for testing*, and add a dummy SPIdev device to cubieboard, cubietruck
and A10S-OLinuXino to facilitate testing with spidev_test."""

Cheers,

Emilio
