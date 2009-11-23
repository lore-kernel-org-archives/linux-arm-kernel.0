From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 23 Nov 2009 14:25:22 -0200
Subject: [PATCH] MX27: Add USB platform devices and resources
In-Reply-To: <20091123153111.GM14091@buzzloop.caiaq.de>
References: <eedb5540907150626m3dbf815bif92ff179b6ebfe58@mail.gmail.com>
	<20090716081235.GQ2714@pengutronix.de>
	<37367b3a0911230436i5d44cd80y182316ef056d6b31@mail.gmail.com>
	<37367b3a0911230718s3dd16d99n1b2ce858b79218ca@mail.gmail.com>
	<20091123153111.GM14091@buzzloop.caiaq.de>
Message-ID: <37367b3a0911230825y55c443d3ga4e70c583a179ff6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 11/23/09, Daniel Mack <daniel@caiaq.de> wrote:
> On Mon, Nov 23, 2009 at 01:18:03PM -0200, Alan Carvalho de Assis wrote:
>> > What do we need now to get USB working on i.MX27?
>> >
>>
>> (replying myself)
>> I think this Daniel Mack's patch will be necessary:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-June/002972.html
>
> The patch you refer to only contains the relevant bits for MX31, you
> would need to tweak it a little to make MX27 work as well. I think this
> has been done already by someone, but I can't remember exactly.
>

Thank you Daniel.

I will try to modify it myself. Case you remember someone who already
do that, please let me know.

>> Sascha, what is missing to this patch be applied?
>
> The patch above and some others are already queued for 2.6.33. The ARM
> specific things are in Sascha's mxc-master, the rest in the USB tree.
>

Great! I think i.MX support on mainline kernel is getting better!

Best Regards,

Alan
