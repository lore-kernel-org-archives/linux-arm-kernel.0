From: matt@console-pimps.org (Matt Fleming)
Date: Fri, 22 Aug 2014 16:47:19 +0100
Subject: [PATCH 5/7 update] arm64/efi: do not enter virtual mode in case
 booting with efi=noruntime or noefi
In-Reply-To: <20140822151007.GA17255@arm.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <1408007731-15081-5-git-send-email-dyoung@redhat.com>
 <20140815150952.GY27466@arm.com>
 <20140818013007.GB3379@darkstar.nay.redhat.com>
 <20140822151007.GA17255@arm.com>
Message-ID: <20140822154719.GN29733@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Aug, at 04:10:07PM, Will Deacon wrote:
> 
> Are you sending these via the efi tree as part of this series, or do you
> need me to pick anything up into the arm64 tree?

I was planning on taking the entire series through the EFI tree (once
I've had chance to review it).

Does that work?

-- 
Matt Fleming, Intel Open Source Technology Center
