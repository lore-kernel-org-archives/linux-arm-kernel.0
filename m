From: bgamari.foss@gmail.com (Ben Gamari)
Date: Tue, 19 Nov 2013 09:59:07 -0500
Subject: cpufreq on PandaBoard
Message-ID: <87eh6ca150.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Booting a PandaBoard with a recent kernel and devicetree appears to be a
rather messy process. There are dozens of devicetree-related warnings
spewed on boot (many pertaining to missing regulators). At the moment,
however, I'm most interested in this,

    cpufreq-cpu0 cpufreq-cpu0.0: no of_node; not parsing pinctrl DT
    cpu cpu0: dummy supplies not allowed
    cpufreq_cpu0: failed to get cpu0 regulator: -19
    cpufreq_cpu0: failed to get cpu0 clock: -2
    cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2

What is the status of cpufreq on the PandaBoard? Is this expected to
work?

More generally, if one wants a fairly recent kernel supporting the
PandaBoard's hardware what kernel tree should be used? Is mainline not
yet appropriate? Is linux-next preferred? Perhaps a ti-maintained tree?

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/97cdc213/attachment.sig>
