From: msalter@redhat.com (Mark Salter)
Date: Wed, 11 May 2016 11:24:12 -0400
Subject: [patch V4 02/31] bitops: Include generic parity.h in some
 architectures' bitops.h
In-Reply-To: <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
 <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Message-ID: <1462980252.9978.33.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-05-11 at 17:06 +0800, zengzhaoxiu at 163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Simply use the generic version.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> [for avr32]
> ---

For c6x:

Acked-by: Mark Salter <msalter@redhat.com>
