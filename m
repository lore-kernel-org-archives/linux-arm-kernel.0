From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 25 Feb 2016 08:57:15 -0700
Subject: [PATCH net-next V2 00/16] net: fec: cleanup and fixes
In-Reply-To: <87oab518wo.fsf@gmail.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <87oab518wo.fsf@gmail.com>
Message-ID: <56CF245B.8050504@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/25/2016 1:39 AM, Holger Schurig wrote:
> Hi Troy,
> 
> what is the general aim of your patches?  Stability?  Speed?  Cleanup?
> 

1. Stability
2. performance
3. easier to read
4. more debug info


The 2nd goal is very hard to measure. It seems function alignment changes swamp
most any other improvements. I think that if the same measurement that I did were done
with a different compiler, you would see different patches increased/decreased
the BPS. But at least the overall trend on the patch set is positive. And
each individual patch has been tested. I would like someone to test on a machine
with 3 queues though.


If you have a more accurate way to measure performance, please let me know.
Also, if you know why freescale's bsp has so much better performance
that would be a very welcome patch.

Troy
