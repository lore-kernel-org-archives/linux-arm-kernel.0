From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 06:55:22 -0800
Subject: [PATCH] ARM: highbank: retry wfi on reset request
In-Reply-To: <1351221637-21747-1-git-send-email-robherring2@gmail.com>
References: <1351221637-21747-1-git-send-email-robherring2@gmail.com>
Message-ID: <20121106145522.GA30580@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 10:20:37PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> In some cases, an interrupt can occur and prevent cause failure to enter
> wfi. This causes reset to hang. Retrying the wfi should be enough to
> prevent reset from hanging.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Applied, thanks.


-Olof
