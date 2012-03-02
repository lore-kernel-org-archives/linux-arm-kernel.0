From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 2 Mar 2012 18:05:54 +0100
Subject: [PATCH] Initial Device Tree system for Snowball
In-Reply-To: <1330703567-17925-1-git-send-email-niklas.hernaeus@stericsson.com>
References: <1330703567-17925-1-git-send-email-niklas.hernaeus@stericsson.com>
Message-ID: <20120302170554.GA21255@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:52 Fri 02 Mar     , Niklas Hernaeus wrote:
> From: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> 
> This is the base system for using Device Tree for Snowball.
> The new boardfile is a slightly modified copy of the original board file,
> so new Device Tree stuff can simply be added and code removed, while
> functionality stays the same.
duplicating the code is not a good idea

do the invert put the minimum in c and then add the rest slowly via DT

Best Regards,
J.
