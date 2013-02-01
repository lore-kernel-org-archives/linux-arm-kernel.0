From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 1 Feb 2013 15:37:52 +0100
Subject: [PATCH 43 0/3] Kirkwoode cpufreq driver
In-Reply-To: <CAKohpokjN8kx9Tan=wG4d0tdicWpb6DLN7o+rbX5f9oppJK7bA@mail.gmail.com>
References: <1359729096-15371-1-git-send-email-andrew@lunn.ch>
 <CAKohpokjN8kx9Tan=wG4d0tdicWpb6DLN7o+rbX5f9oppJK7bA@mail.gmail.com>
Message-ID: <20130201143752.GQ17242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 08:04:27PM +0530, Viresh Kumar wrote:
> On 1 February 2013 20:01, Andrew Lunn <andrew@lunn.ch> wrote:
> > This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.
> >
> > The changes to kirkwood_defconfig enable it and set the default
> > governor to ondemand.
> 
> Wow! [PATCH 43 0/3] :)
> It looks you are adding v4 manually to every patch? 

No, I just edited the cover note. For the others i used --subject=...

    Andrew
