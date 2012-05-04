From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 08:39:51 +0100
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
References: <201205031350.35476.arnd@arndb.de>
 <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
Message-ID: <20120504073951.GB26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 10:38:15PM -0700, Deepak Saxena wrote:
> I'm of the opinion that we support DT only platforms for
> multi-platform but this is based on the approach of only caring for
> multi-platform for newer systems and not worrying too much for legacy
> HW.

You do realise that you're advocating that we forcefully regress stuff
that works today.  Sorry, that's not going to happen.
