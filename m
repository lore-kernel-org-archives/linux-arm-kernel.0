From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 22 Jun 2012 14:55:52 +0100
Subject: [PATCH v3 3/4] dt: add clock binding doc to primecell bindings
In-Reply-To: <1339512111-11172-4-git-send-email-robherring2@gmail.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <1339512111-11172-4-git-send-email-robherring2@gmail.com>
Message-ID: <4FE47968.9040105@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 15:41, Rob Herring wrote:
> From: Rob Herring<rob.herring@calxeda.com>
>
> Add clock binding information for primecell peripherals. For most, a
> clock input name of "apb_pclk" is required. Any primecell peripherals
> which are different will need to be documented separately.

Really they should just use NULL as their bus clock name,
and the drivers be fixed for this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
