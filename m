From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 4 Jan 2012 17:49:37 +0000
Subject: GPIO matrix and button with single edge IRQ
In-Reply-To: <CAHEb4-8Xo=w5GuYQzP8X3h_HW8yHG89T+oGRfZJNa652St=YnA@mail.gmail.com>
References: <CAHEb4-8Xo=w5GuYQzP8X3h_HW8yHG89T+oGRfZJNa652St=YnA@mail.gmail.com>
Message-ID: <20120104174937.GA3104@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Jan 04, 2012 at 07:54:06AM -0500, Marc-Andr? H?bert wrote:
> We are developing an i.MX283 custom board. We have a small keypad
> matrix and some gpio buttons. After setting up the necessary platform
> data, I realized when debugging that it couldn't work because the GPIO
> controller does not support dual edge triggers like requested in both

Does the GPIO controller support both edge types but not at the same 
time?  LinusW pointed out to me that a couple of other controllers have 
this restriction but you can work around it in the controller driver:

http://www.spinics.net/lists/arm-kernel/msg152526.html

Jamie
