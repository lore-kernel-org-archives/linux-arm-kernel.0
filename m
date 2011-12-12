From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 12 Dec 2011 18:12:43 +0100
Subject: [PATCH V2] mfd: Fixed mixed up ADC single channel readout
In-Reply-To: <1322479247-13318-1-git-send-email-robin@protonic.nl>
References: <1322479247-13318-1-git-send-email-robin@protonic.nl>
Message-ID: <20111212171243.GQ13952@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Mon, Nov 28, 2011 at 12:20:47PM +0100, Robin van der Gracht wrote:
> In single channel mode, when reading the ADC result, the index value
> is still set to the channel selected for this reading.
> This mixes up the order of the values returned. This causes problems when
> the converted results are made available in pairs (i.e. battery current reading)
> To straighten this up, the index value needs to be reset, so that the
> converted values are read at the assigned channel.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
I'm not familiar with the HW, so I'd need Uwe's ACK here.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
