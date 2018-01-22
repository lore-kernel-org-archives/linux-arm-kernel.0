From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Jan 2018 11:53:31 +0000
Subject: [PATCH] ARM-SMMU: Delete error messages for a failed memory
 allocation in three functions
In-Reply-To: <ac171b23-624d-2df3-d1d1-8e9479ae03bc@arm.com>
References: <c3e91414-dd5b-2889-d86c-b19aff56571b@users.sourceforge.net>
 <ac171b23-624d-2df3-d1d1-8e9479ae03bc@arm.com>
Message-ID: <20180122115331.GE15456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 11:47:13AM +0000, Robin Murphy wrote:
> On 20/01/18 14:36, SF Markus Elfring wrote:
> >From: Markus Elfring <elfring@users.sourceforge.net>
> >Date: Sat, 20 Jan 2018 15:30:17 +0100
> >
> >Omit extra messages for a memory allocation failure in these functions.
> 
> Why?

Don't worry -- I was ignoring this patch (and I assume Joerg does the same).

Will
