From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Oct 2014 16:15:20 +0100
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <20141027161226.199cca96@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024142044.GB3142@lunn.ch>
 <20141024162824.67f9ce3d@free-electrons.com>
 <20141024145119.GD3142@lunn.ch>
 <20141027135129.292bd882@free-electrons.com>
 <20141027141958.GB12627@lunn.ch>
 <20141027154049.583e4cd2@free-electrons.com>
 <20141027145939.GD12627@lunn.ch>
 <20141027161226.199cca96@free-electrons.com>
Message-ID: <20141027151520.GA29934@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So I'm a bit reluctant to create a dependency of the Armada XP
> suspend/resume code to a very large unmerged patch series that doesn't
> seem to even be close of having a consensus amongst the maintainers.

I totally agree.

> Isn't this something we can rework afterwards once the poweroff
> discussion has settled? I wouldn't mind declaring the particular
> aspects of the DT bindings related to the PIC GPIOs as "staging", so
> that we keep the freedom to change them for a few kernel releases until
> we settle on the final solution for that.

Yes. That seems very reasonable.

     Andrew
