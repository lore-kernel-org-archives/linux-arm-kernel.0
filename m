From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 30 Jul 2012 16:00:56 +0300
Subject: [PATCH 1/5] ubi: introduce ubi->bad_peb_limit
In-Reply-To: <20120719091600.7d55dadb@pixies.home.jungo.com>
References: <1341389164-24409-1-git-send-email-shmulik.ladkani@gmail.com>
 <1341389164-24409-2-git-send-email-shmulik.ladkani@gmail.com>
 <1342608053.7530.11.camel@brekeke>
 <20120719091600.7d55dadb@pixies.home.jungo.com>
Message-ID: <1343653256.1513.6.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-19 at 09:16 +0300, Shmulik Ladkani wrote:
> On Wed, 18 Jul 2012 13:40:53 +0300 Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > I've also amended the Kconfig text a tiny bit and dropped the defconfig
> > changes - let's have them separately as a single patch at the end of the
> > series.
> 
> Wouldn't having the defconfig change as the last patch break things for
> those defconfigs that had explicitly set CONFIG_MTD_UBI_BEB_RESERVE
> other than the default?

OK, fair enough, but let's have it as a 2 separate patches anyway. It is
not a big deal to first change the defconfig, and then actually add the
new option.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120730/a9d45a61/attachment.sig>
