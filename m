From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 14:39:35 -0700
Subject: [GIT PULL] at91: DT for 3.16 #2
In-Reply-To: <20140521211105.GD24341@quad.lixom.net>
References: <1400059162-630-1-git-send-email-nicolas.ferre@atmel.com>
 <20140520055041.GO18956@quad.lixom.net>
 <537B727C.5080404@atmel.com> <20140520164746.GA601@quad.lixom.net>
 <537C7D25.6060705@atmel.com>
 <20140521211105.GD24341@quad.lixom.net>
Message-ID: <CAOesGMgYe=8usEDMemLfwu-amfiEJAWCqKu4GjV4oLwK8u8K0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 2:11 PM, Olof Johansson <olof@lixom.net> wrote:

> I don't agree with everything above, but it's not worth arguing for the
> sake of arguing. :) I think we can tweak what you're doing now and get
> things to work well by merging new dts files with at91-<soc>-board.dts
> as the name. As mentioned, don't worry about the existing files. This
> shouldn't be a significiant change to what you've been telling people
> since 3.10 to cause much confusion.

A the end of the day, as long as you have at91- as prefix we'll be OK I think.

If you can consistently add the SoC into the prefix as above, we'll be
even better. But I'm not going to spend more time arguing it. :)

Either way, consistency (going forward) with at91- is good.

-Olof
