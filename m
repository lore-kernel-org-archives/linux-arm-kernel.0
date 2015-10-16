From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Oct 2015 15:34:53 +0100
Subject: Aarch32 user space PC alignment exception
In-Reply-To: <1444771874-22714-1-git-send-email-salyzyn@android.com>
References: <1444771874-22714-1-git-send-email-salyzyn@android.com>
Message-ID: <20151016143452.GD6613@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 02:30:51PM -0700, Mark Salyzyn wrote:
> armv7 does not have a PC alignment exception. armv8 Aarch32
> user space however can produce a PC alignment exception. Add
> handler so the we do not dump an unexpected stack trace in
> the logs.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>

Queued for 4.4. Thanks.

-- 
Catalin
