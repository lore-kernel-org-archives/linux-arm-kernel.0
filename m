From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 13 Aug 2014 15:22:07 +0100
Subject: [PATCH 2/5] efi: add kernel param efi=noruntime
In-Reply-To: <20140813081347.GA3977@darkstar.nay.redhat.com>
References: <1407823822-23829-1-git-send-email-dyoung@redhat.com>
 <1407823822-23829-2-git-send-email-dyoung@redhat.com>
 <20140813081347.GA3977@darkstar.nay.redhat.com>
Message-ID: <20140813142207.GR15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Aug, at 04:13:47PM, Dave Young wrote:
> 
> For sharing functions I moved old_map here, but rethinking about it maybe
> it's better to keep it in arch code.
> 
> Matt, I see you have some code for libstub option parsing, I will rebase
> on your efi/next and I'm thinking to add a generic function for parsing
> params like below (for old_map, but libstub can not use it):
 
Makes sense to me.

-- 
Matt Fleming, Intel Open Source Technology Center
