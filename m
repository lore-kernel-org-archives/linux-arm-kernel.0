From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Feb 2012 15:01:44 -0800
Subject: [PATCH 3/3] ARM: remove empty disable_fiq and arch_ret_to_user
 macros
In-Reply-To: <1328562200-8810-4-git-send-email-robherring2@gmail.com>
References: <1328562200-8810-1-git-send-email-robherring2@gmail.com>
 <1328562200-8810-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120206230144.GB20333@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [120206 12:36]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that most platforms don't need disable_fiq and arch_ret_to_user
> macros, we can remove the empty macros or empty entry-macro.S files.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

For omaps:

Acked-by: Tony Lindgren <tony@atomide.com>
