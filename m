From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 13 Aug 2018 01:56:12 -0700
Subject: [PATCH v8 1/6] Uprobes: Simplify uprobe_register() body
In-Reply-To: <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
Message-ID: <20180813085612.GE44470@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-09 09:48:51]:

> Simplify uprobe_register() function body and let __uprobe_register()
> handle everything. Also move dependency functions around to fix build
> failures.
> 

One nit:
s/to fix build/failures/to avoid build failures/



> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---


Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
