From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Aug 2014 12:46:47 -0300
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <1407509932.19455.7.camel@sharkbay.at>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
 <20140808143008.GD30282@n2100.arm.linux.org.uk>
 <1407509932.19455.7.camel@sharkbay.at>
Message-ID: <CAOMZO5C=sTL-ksaHX9uL=zyGR0d5hR8Rd5JAiQMTrr_0wiNdxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Aug 8, 2014 at 11:58 AM, Thomas Scheiblauer <tom@sharkbay.at> wrote:

>> So, what I'm asking is to try without this workaround in case there is
>> some interaction there, thus testing the same interrupt configuration
>> that I've had here for the last 10 months without the kind of issues
>> you're reporting.  Sometimes, workarounds for one problem end up causing
>> other problem elsewhere.
>>
>
> Indeed, commenting out these 2 lines in
> arch/arm/boot/dts/imx6qdl-wandboard.dtsi fixes my problem without having
> to increase TX_RING_SIZE.
> Thank you very much!

Could you please send a patch for imx6qdl-wandboard.dtsi? Please
provide the details of the problem in the commit log.

Thanks
