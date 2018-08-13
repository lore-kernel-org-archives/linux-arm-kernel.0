From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 13 Aug 2018 01:50:59 -0700
Subject: [PATCH v8 4/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
In-Reply-To: <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
Message-ID: <20180813085059.GC44470@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-09 09:48:54]:

> We assume to have only one reference counter for one uprobe.
> Don't allow user to register multiple uprobes having same
> inode+offset but different reference counter.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
Looks good to me.

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
