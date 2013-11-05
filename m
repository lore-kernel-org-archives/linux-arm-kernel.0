From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 10:32:53 -0800
Subject: [PATCH v3 18/28] mtd: nand: pxa3xx: Split
 prepare_command_pool() in two stages
In-Reply-To: <1383656135-8627-19-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-19-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131105183253.GP20061@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:55:25AM -0300, Ezequiel Garcia wrote:
> This commit splits the prepare_command_pool() function into two
> stages: prepare_start_command() / prepare_set_command().
> 
> This is a preparation patch without any functionality changes,
> and is meant to allow support fir multiple page reading/writing

s/fir/for/

> operations.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Brian
