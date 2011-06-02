From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 2 Jun 2011 18:32:37 +0200
Subject: [PATCH RFC] at91: Use "pclk" as con_id on at91cap9 and at91rm9200
In-Reply-To: <BANLkTikDJhE6dbGmz5QAgEJeKRknp2jDpw@mail.gmail.com>
References: <BANLkTikDJhE6dbGmz5QAgEJeKRknp2jDpw@mail.gmail.com>
Message-ID: <20110602163237.GI32751@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01:36 Thu 02 Jun     , Joachim Eastwood wrote:
> Hello,
> 
> I am not 100% sure this is the right thing to do, but it makes the
> atmel-ssc driver happy on my at91rm9200 board.
> 
> 
> 
> This unifies the con_id across all at91 machines.
> 
> The atmel-ssc driver expects the con_id to be "pclk" or it will fail probing.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
