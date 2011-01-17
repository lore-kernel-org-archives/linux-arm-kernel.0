From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Jan 2011 10:01:58 +0000
Subject: [PATCH 2/3] support ARM BE8 mode on a little endian machine
In-Reply-To: <1295253729-23153-3-git-send-email-stanley.miao@windriver.com>
References: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>
	<1295253729-23153-3-git-send-email-stanley.miao@windriver.com>
Message-ID: <AANLkTimXAtpRz=ZjmN8brHMQNqgGMKhpo=v_sFk_Aeuf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2011 08:42, Stanley.Miao <stanley.miao@windriver.com> wrote:
> When BE8 kernel is running on a little endian machine, the kernel endian
> mode need to be converted at the begining of the startup procedure with
> the instruction "setend be".

Can we not let the boot loader do this? It could also prepare the tags
as big endian.

-- 
Catalin
