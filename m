From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 1 May 2017 16:44:32 -0700
Subject: [PATCH] mtd: nand: tango: Export OF device ID table as module
 aliases
In-Reply-To: <20170501203015.7275-1-andresgalacho@gmail.com>
References: <20170501203015.7275-1-andresgalacho@gmail.com>
Message-ID: <20170501234432.GA18576@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 01, 2017 at 04:30:15PM -0400, Andres Galacho wrote:
> The device table is required to load modules based on
> modaliases. After adding MODULE_DEVICE_TABLE, below entries
> for example will be added to module.alias:
> alias:          of:N*T*Csigma,smp8758-nandC*
> alias:          of:N*T*Csigma,smp8758-nand
> 
> Signed-off-by: Andres Galacho <andresgalacho@gmail.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>
