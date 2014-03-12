From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Mar 2014 18:03:42 +0000
Subject: [PATCH 1/2] arm64: debug: make local symbols static
In-Reply-To: <000001cf3834$9667e5c0$c337b140$%han@samsung.com>
References: <000001cf3834$9667e5c0$c337b140$%han@samsung.com>
Message-ID: <20140312180341.GV17083@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 05:34:32AM +0000, Jingoo Han wrote:
> Make local symbols static, because these are used only in this
> file.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied (both). Thanks.

-- 
Catalin
