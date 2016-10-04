From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Oct 2016 14:12:51 +0200
Subject: [PATCH 02/14] clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to
 ac-dig
In-Reply-To: <8dfe0935d35b8a218ebf39d37113e27289a0de9b.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <8dfe0935d35b8a218ebf39d37113e27289a0de9b.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004141251.4e82378e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue,  4 Oct 2016 11:46:15 +0200, Myl?ne Josserand wrote:
> Add the flag CLK_SET_RATE_PARENT to 'ac-dig' clock.

There is no need to repeat the commit title inside the commit log
itself. What would be more useful is to explain *why* this is needed.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
