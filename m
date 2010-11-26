From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 26 Nov 2010 00:18:49 -0700
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <20101126045912.GC6598@lixom.net>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-2-git-send-email-ohad@wizery.com>
	<20101126045912.GC6598@lixom.net>
Message-ID: <AANLkTimkovvHzgdnGtGpTH1pz8QLi9K0-rcWVHCdMJbu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 9:59 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Nov 23, 2010 at 05:38:57PM +0200, Ohad Ben-Cohen wrote:
>> +#define pr_fmt(fmt) ? ?"%s: " fmt, __func__
>
> Not used.

pr_fmt() is a magic #define that changes the behaviour of the pr_*()
macros.  See include/linux/kernel.h

g.
