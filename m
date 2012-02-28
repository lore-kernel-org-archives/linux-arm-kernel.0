From: stigge@antcom.de (Roland Stigge)
Date: Tue, 28 Feb 2012 19:19:36 +0100
Subject: [PATCH v3] ARM: LPC32xx: USB Support
In-Reply-To: <20120228175735.GB14290@kroah.com>
References: <1330178224-24999-1-git-send-email-stigge@antcom.de>
 <1330178224-24999-2-git-send-email-stigge@antcom.de>
 <20120228175735.GB14290@kroah.com>
Message-ID: <4F4D1AB8.9060307@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 02/28/2012 06:57 PM, Greg Kroah-Hartman wrote:
>> (This is the mach-lpc32xx specific part, the USB subsystem specific changes are
>> in a separate patch for the USB maintainers.)
> 
> Do you want/need me to take both of these?  Or just the first one?  Or,
> just ack the first one so the arm maintainers can take this one?  It's
> your choice...

The first one (actual driver) is for you to take as USB maintainer
and/or ack.

The other one is for arm-soc, and just for informational purposes for you.

Thanks in advance,

Roland
