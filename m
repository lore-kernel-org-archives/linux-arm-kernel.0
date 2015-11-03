From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 03 Nov 2015 00:57:16 +0000
Subject: [PATCH v8 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <56379945.6020407@sigmadesigns.com> (Marc Gonzalez's message of
 "Mon, 2 Nov 2015 18:11:33 +0100")
References: <56377E76.2080209@sigmadesigns.com>
 <56377ED5.4070203@sigmadesigns.com>
 <yw1xk2q09yrj.fsf@unicorn.mansr.com>
 <56379945.6020407@sigmadesigns.com>
Message-ID: <yw1xy4ef99xv.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

>>> +		compatible = "fixed-factor-clock";
>>> +		clocks = <&clkgen 0>;
>>> +		clock-mult = <1>;
>>> +		clock-div  = <2>;
>> 
>> Some Sigma source code I found on the Internet uses a divisor of 3.
>> Which is correct?
>
> I was told 2.

Just to be sure, I measured it.  It's 2.

-- 
M?ns Rullg?rd
mans at mansr.com
