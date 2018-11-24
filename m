From: digetx@gmail.com (Dmitry Osipenko)
Date: Sat, 24 Nov 2018 14:20:58 +0300
Subject: [PATCH v3 4/4] ARM: dts: Add stmpe-adc driver to relevant
 devicetrees
In-Reply-To: <20181123142411.8921-4-dev@pschenker.ch>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-4-dev@pschenker.ch>
Message-ID: <2c7d4caa-4a6e-cea1-d394-51790227d968@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.11.2018 17:24, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Hello Philippe,

Just a very minor comment.. device trees are not for drivers, but for HW description. It will be better to s/driver/DT node/ in both commit name and description.
