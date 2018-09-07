From: james.morse@arm.com (James Morse)
Date: Fri, 7 Sep 2018 10:57:25 +0100
Subject: [RESEND PATCH v4 4/6] arm64/mm: Create the final page table
 directly in swapper_pg_dir.
In-Reply-To: <20180822095432.12125-5-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-5-yaojun8558363@gmail.com>
Message-ID: <3cbcf8b6-682c-d08c-3375-4cad099420cf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> As the initial page table is created in the init_pg_dir, we can set
> up the final page table directly in the swapper_pg_dir. And it only> contains the top level page table, so we can reduce it to a page

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
