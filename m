From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 29 Jan 2013 12:14:02 +1100
Subject: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic()
 to prevent CPU offline
In-Reply-To: <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
 <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
 <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
Message-ID: <5107225A.5040702@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 06:06 AM, Tejun Heo wrote:
> Hello, Bob.
> 
> On Mon, Jan 28, 2013 at 1:09 AM, Bob Liu <lliubbo@gmail.com> wrote:
>> Thanks, will be applied to my blackfin arch tree.
> 
> I think we still have some work ahead of us to have this patchset
> ready for inclusion and even then it probably would be best to route
> these patches together, so probably not a very good idea to apply this
> to blackfin right now.
> 

Thanks Tejun for pointing that out! I'll address the review comments
soon and respin the patchset.
 
Regards,
Srivatsa S. Bhat
