From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 13 Aug 2018 01:51:46 -0700
Subject: [PATCH v8 2/6] Uprobe: Additional argument arch_uprobe to
 uprobe_write_opcode()
In-Reply-To: <20180809041856.1547-3-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-3-ravi.bangoria@linux.ibm.com>
Message-ID: <20180813085146.GD44470@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-09 09:48:52]:

> Add addition argument 'arch_uprobe' to uprobe_write_opcode().
> We need this in later set of patches.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Looks good to me.

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
