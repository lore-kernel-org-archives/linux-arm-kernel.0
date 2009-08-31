From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 31 Aug 2009 09:05:59 +0100
Subject: [PATCH] ARM: Mailing lists have moved
In-Reply-To: <f17812d70908310022v1338899bibd3f6f9b5ff4ca5e@mail.gmail.com>
References: <1250855566.3311.100.camel@macbook.infradead.org>
	<20090824073525.GA21356@kos.to>
	<1251100978.25155.18.camel@macbook.infradead.org>
	<20090824083242.GA26725@elf.ucw.cz>
	<1251106506.25155.43.camel@macbook.infradead.org>
	<f17812d70908310022v1338899bibd3f6f9b5ff4ca5e@mail.gmail.com>
Message-ID: <1251705959.16594.88.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-08-31 at 15:22 +0800, Eric Miao wrote:
> I canot find the 'List-Id' that is usually present on other mailing list,
> which I normally use as a filter condition. Could you please help check
> if this is possible on lists.infradead.org?

You can get false positives if you filter on that.

The most reliable way to filter mailing lists is on the reverse-path
(which often appears in a Return-Path: or Sender: header at delivery).
That should match 'linux-arm-kernel-bounces.*@lists.infradead.org'

But the List-Id header definitely does seem to be present.

-- 
dwmw2
