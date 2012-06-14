From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 14 Jun 2012 10:52:57 +0300
Subject: [PATCH v4] usb: chipidea: permit driver bindings pass phy pointer
In-Reply-To: <20120612231438.GA6177@kroah.com>
References: <1337912665-16615-3-git-send-email-richard.zhao@freescale.com>
 <1339159026-15837-1-git-send-email-richard.zhao@freescale.com>
 <20120612231438.GA6177@kroah.com>
Message-ID: <8762au8h46.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Fri, Jun 08, 2012 at 08:37:06PM +0800, Richard Zhao wrote:
>> Sometimes, the driver bindings may know what phy they use.
>> For example, when using device tree, the usb controller may have a
>> phandler pointing to usb phy.
>> 
>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> ---
>> Changes since laster version:
>> - hcd transceiver renamed to phy
>
> Ick, I see patches all over this thread, and other threads, and I have
> no idea what to apply anywhere...
>
> So, consider all chipidea patches dropped from my queue now, can you
> please resend them to me, with the accumulated acks and reviewed-by
> line, so that I can queue them up?

So will you pick these patches to your tree or should I apply them to
mine or what is the plan? I kind of have a tree [1] for chipidea stuff
where I have been collecting patches, to send a pull request to you for
3.6.

[1] git://github.com/virtuoso/linux-ci.git ci

Regards,
--
Alex
