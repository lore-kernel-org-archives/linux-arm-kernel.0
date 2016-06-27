From: geoff@infradead.org (Geoff Levand)
Date: Mon, 27 Jun 2016 09:44:20 -0700
Subject: [PATCH v20 01/14] arm64: hibernate: Don't hibernate on systems
 with stuck CPUs
In-Reply-To: <57710843.40806@arm.com>
References: <cover.1466702804.git.geoff@infradead.org>
 <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
 <57710843.40806@arm.com>
Message-ID: <1467045860.7965.31.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2016-06-27 at 12:04 +0100, James Morse wrote:
> ... this patch isn't necessary for kexec, it wired up the helper
> function you
> have in patch 2 for hibernate.
> 
> Please drop this in any future posting!

It seems both your patches I had went in for -rc5, so
they're gone now from my master.

-Geoff
