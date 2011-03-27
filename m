From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 27 Mar 2011 18:55:15 +0400
Subject: [PATCH] arm: disable non-existent prpmc1100 code.
In-Reply-To: <20110326161711.GA573@riccoc20.at.omicron.at>
References: <20110326161711.GA573@riccoc20.at.omicron.at>
Message-ID: <4D8F4FD3.6070800@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-03-2011 19:17, Richard Cochran wrote:

> Commit 6f82f4db80189281a8ac42f2e72396accb719b57 removed the prpmc110 from

    Please also specify that commit's summary in parens for the human readers.

> the list of machine types. This commit disables a PCI fixup function for
> that board, since its presence is preventing the kernel from compiling.

> Signed-off-by: Richard Cochran<richard.cochran@omicron.at>

WBR, Sergei
