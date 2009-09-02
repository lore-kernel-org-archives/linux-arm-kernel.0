From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 2 Sep 2009 14:28:51 +0800
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <f17812d70909012325h42a834cqad3627fb3e4fe62d@mail.gmail.com>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<200909011256.10882.sleep_walker@suse.cz> <4A9D0896.2000007@gmail.com>
	<200909011814.03109.sleep_walker@suse.cz>
	<f17812d70909012325h42a834cqad3627fb3e4fe62d@mail.gmail.com>
Message-ID: <f17812d70909012328y78176439kd0b6f139020e9e5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry this might be html,send from my g1).
currently, I dont think gpio for pxafb is necessary, request and init in
board_init() should be just ok.

On Sep 2, 2009 12:14 AM, "Tom?? &apos;Sleep_Walker&apos; ?ech" <
sleep_walker@suse.cz> wrote:

Hi,

Dne ?t 1. z??? 2009 13:42:14 Eric Miao napsal(a):

> Tom?? 'Sleep_Walker' ?ech wrote: > > Hi, > > > > Dne ?t 1. z??? 2009
11:49:24 Eric Miao napsal(a)...
There can be problem with this. It's easy to create such function, but there
is no place for initialization so I would need to call gpio_register() and
gpio_direction_output() in machine init function or even elsewhere which I
find a bit nasty. Should I try to update pxafb to support LCD power through
GPIO too or go nasty way?

Thanks Best regards, Tomas Cech
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090902/6d8e7e61/attachment.htm>
