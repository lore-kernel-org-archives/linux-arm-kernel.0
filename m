From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 11 Sep 2014 01:29:29 +0200
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <20140910141850.34c07f72@canb.auug.org.au>
References: <20140910141850.34c07f72@canb.auug.org.au>
Message-ID: <24748175.vQ81Vho3N1@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 10, 2014 02:18:50 PM Stephen Rothwell wrote:
> Hi Rafael,
> 
> Today's linux-next merge of the pm tree got a conflict in
> arch/arm/mach-shmobile/setup-sh73a0.c between commit aa0bdc303b0f
> ("ARM: shmobile: sh73a0: Remove duplicate CPUFreq bits") from the
> arm-soc tree and commit 978027e170fb ("cpufreq: cpu0: rename driver and
> internals to 'cpufreq_dt'") from the pm tree.
> 
> I fixed it up (the former removed the lines that were updated by the
> latter) and can carry the fix as necessary (no action is required).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/6764050c/attachment.sig>
