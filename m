From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 14 Jun 2017 09:43:44 +0200
Subject: [PATCH] tty/serial: remove AVR32 specific access wrappers
In-Reply-To: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
References: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
Message-ID: <b3c66ec1-1f5b-3d46-79b4-3420f1e754d6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2017 22:25, Alexandre Belloni wrote:
> Now that AVR32 is gone, the specific wrappers for that architecture are
> unnecessary and will not be compiled anymore.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Richard Genoud <richard.genoud@gmail.com>
