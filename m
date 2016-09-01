From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 1 Sep 2016 20:55:38 +0100
Subject: [STLinux Kernel] [PATCH 1/9] serial: st-asc: constify uart_ops
 structures
In-Reply-To: <1472752298-981-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472752298-981-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160901195538.GA19072@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 01 Sep 2016, Julia Lawall wrote:

> Check for uart_ops structures that are only stored in the ops field of a
> uart_port structure.  This field is declared const, so uart_ops structures
> that have this property can be declared as const also.

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
