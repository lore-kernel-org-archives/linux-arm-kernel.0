From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 6 Jan 2015 15:25:28 +0100
Subject: AT91 slow clock mode regression/fixes, improvement proposal
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFCD1D0C@penmbx01>
References: <20141218203904.GA25215@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6762@penmbx01>
 <20141219152625.GA30666@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6CA0@penmbx01>
 <B256D81BAE5131468A838E5D7A243641BFCD1D0C@penmbx01>
Message-ID: <20150106142528.GA10330@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Mon, Jan 05, 2015 at 03:32:42AM +0000, Yang, Wenyou wrote:
> 
> I remembered you said this patch is not formal. Now, would you like 
> send a formal one?

Here it is, the first one is based on linux-at91/linux-3.10-at91 branch, 
the second one is rebased on linux-3.18 (Is this the right way when 
playing with multiple branch?).

By the way, Wenyou fixed some bugs in the linux-3.10-at91 branch about 
slow clock mode which should IMHO be merged and pushed to other 
branches.

Regards,
Sylvain
