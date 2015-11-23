From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 Nov 2015 12:52:18 +0100
Subject: [linux-meson] AMLogic Meson serial driver fixes
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAOQ7t2aHgsOHsgXCPMGXgwn4HJS+VFgqQp=n3jsPREurVpPp7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 3:41 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Whilst testing the 4.3 kernel on an AMlogic AM805 (Odroid-C1) with
> a systemd based system, the console has issues with missing parts
> of the output.
>
> This is a set of fixes, and a few cleanups which makes the output
> when the console is set to ttyAML0 usable.
>

nit: next time use '--cover-letter' to generate the cover.

For whole patchset:

Tested-by: Carlo Caione <carlo@endlessm.com>

Thanks!

-- 
Carlo Caione
