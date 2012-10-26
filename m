From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 26 Oct 2012 11:17:51 -0700
Subject: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com> (Mike
 Turquette's message of "Wed, 3 Oct 2012 18:16:00 -0700")
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Message-ID: <87fw51hzcg.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Mike Turquette <mturquette@ti.com> writes:

> From: Mike Turquette <mturquette@linaro.org>
>
> This series creates a new callback for struct voltagedomain,
> .get_voltage.  This fetches the voltage from hardware, if possible, and
> returns it to the caller.  We use this call to populate
> voltdm->nominal_volt at boot time.

I pointed out a couple nitpicky things on individual patches, but
otherwise this direction and motiviation for this series looks OK by me.

Just some minor comments about the structure of the series.  I tend to
prefer combining the introduction of a new function with it's usage.  It
makes review and understanding much easier, IMO.  If there are reasons
to keep them separate, that's fine too.  Just describe the reasons in
the cover letter.

Thanks,

Kevin
