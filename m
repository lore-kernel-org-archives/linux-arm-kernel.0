From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 06 Nov 2013 10:50:00 +1000
Subject: [PATCHv3] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <20131105155701.GL3060@titan.lakedaemon.net>
References: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
 <20131104145151.GD3060@titan.lakedaemon.net>
 <20131104145739.GE3060@titan.lakedaemon.net> <52785FAE.7040904@uclinux.org>
 <20131105155701.GL3060@titan.lakedaemon.net>
Message-ID: <52799238.9010803@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 06/11/13 01:57, Jason Cooper wrote:
> On Tue, Nov 05, 2013 at 01:02:06PM +1000, Greg Ungerer wrote:
>> Hi Jason,
>>
>> On 05/11/13 00:57, Jason Cooper wrote:
>>> On Mon, Nov 04, 2013 at 09:51:51AM -0500, Jason Cooper wrote:
>>>> What happened to the rest of the series?
>>>
>>> Crap.  Nevermind.  I just saw that Shawn had already taken the other
>>> patches into his tree.  And here I thought I was caught up on
>>> everything...
>>
>> :-)
>>
>> Are you going to try and test out the imx50 support from Shawn's branch?
> 
> I did manage to get it to boot, but I'm not confident in it yet.  There
> is still a nagging problem (I had with my implementation as well) where
> 
> $ sleep 10
> 
> takes greater than 20 seconds. :(  Which is why I originally asked you
> about the apll...

I have seen that. I haven't had a chance to look properly into it.
If you boot Freescales old LTIB code that supports the iMX50 it seems
they are messing with the clock setup to get it just right. It may
be that they just didn't get it right in their boot loader to start
with.

Regards
Greg
