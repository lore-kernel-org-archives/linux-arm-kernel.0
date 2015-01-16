From: javi.merino@arm.com (Javi Merino)
Date: Fri, 16 Jan 2015 12:10:50 +0000
Subject: RFC on cpufreq implementation
In-Reply-To: <54B8F19F.8060108@free.fr>
References: <54B7F7CD.7030903@free.fr> <1421399293.11224.7.camel@AMDC1943>
 <54B8F19F.8060108@free.fr>
Message-ID: <20150116121049.GB2898@e104805>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mason,

On Fri, Jan 16, 2015 at 11:10:23AM +0000, Mason wrote:
[...]
> OK. I'm also interested in frequency-throttling when temperatures
> rise beyond specific thresholds. What subsystem ties sensors and
> cpufreq together?

The thermal framework.  Have a look at
Documentation/thermal/sysfs-api.txt and
Documentation/thermal/cpu-cooling-api.txt

Cheers,
Javi
