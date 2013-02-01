From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Feb 2013 20:04:27 +0530
Subject: [PATCH 43 0/3] Kirkwoode cpufreq driver
In-Reply-To: <1359729096-15371-1-git-send-email-andrew@lunn.ch>
References: <1359729096-15371-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAKohpokjN8kx9Tan=wG4d0tdicWpb6DLN7o+rbX5f9oppJK7bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2013 20:01, Andrew Lunn <andrew@lunn.ch> wrote:
> This patchset adds a cpufreq driver for Marvell Kirkwood SoCs.
>
> The changes to kirkwood_defconfig enable it and set the default
> governor to ondemand.

Wow! [PATCH 43 0/3] :)
It looks you are adding v4 manually to every patch? If yes, you need to
use following:

git format-patch A..B --cover-letter --subject-prefix="PATCH V4"
