From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 08 Nov 2013 12:34:36 +0800
Subject: [Consult] Do we need related web site link in "./COPYING" file?
Message-ID: <527C69DC.80901@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All:

I guess COPYING is our GPL License file, it already contents related
Free Software Foundation address. Do we also need content related web
site link?

When make patch for "arch/arm64/include/uapi/", "scripts/checkpatch.pl"
will report the issue below:

  ERROR: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
  #209: FILE: arch/arm64/include/uapi/asm/signal.h:13:
    * You should have received a copy of the GNU General Public License$

I guess, "scrpits/checkpatch.pl" wants to say: "the Linux GPL copy
already contents related web site, so need not 'hard code' them in
another place".


BTW: I find some "^L" in COPYING file, are they for page separation?


Welcome any suggestions or completions.

Thanks.
-- 
Chen Gang
