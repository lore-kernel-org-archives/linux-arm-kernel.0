From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 15:10:40 +0200
Subject: [GIT PULL v3] STi SoC changes for v4.8
In-Reply-To: <57834D9D.4070900@st.com>
References: <57834D9D.4070900@st.com>
Message-ID: <5162937.DKTOH8rVm0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 11, 2016 9:41:17 AM CEST Patrice Chotard wrote:
> Highlights:
> -----------
> - Add a dummy L2 cache's write_sec callback as in non secure mode execution,
>     we can't get access to L2 cache secure registers
> - Cosmetics change, in case of dump_stack, update the hardware name with a
>     more generic for the STi SoCs family

Merged into next/soc. Note that you can skip the "Highlights" and "-------"
lines in the tag, just write it the way you want it to appear in the
git history. I actually prefer normal sentences, but lists like you have
here are also fine. Ideally start with a one-line description of
the branch.

	Arnd
