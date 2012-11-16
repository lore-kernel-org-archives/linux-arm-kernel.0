From: sameer@falkorsystems.com (Sameer Parekh)
Date: Thu, 15 Nov 2012 22:18:33 -0500
Subject: high resolution EhrPWM with Ubuntu Linux on BeagleBone
Message-ID: <100CF1C57FAB4B97875769D6FCCEBDBE@falkorsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello--
Apologies if this is the wrong list for this question-- if someone could point me to the right list, I would appreciate it.

I am trying to get high resolution PWM out of my beagle bone running ubuntu 12.10 to control servos and other hobby RC gear. I have successfully been able to use the /sys/class/pwm/ehrpwm to create PWM output, however I am having trouble with the resolution.

The RC standard is to run at 50Hz with each PWM signal lasting from 1000-2000us. I have set the frequency to 50, however it appears that the duty_cycle must be passed as an integer percentage. Therefore in order to get 1ms I set the duty cycle to 5 and to get 2ms I set the duty cycle to 10. This gives me only 200us resolution, while I would prefer resolution closer to 1us,

Is that possible using the standard pwm support? 

Thanks,
-- 
Sameer Parekh
Falkor Systems, Inc.




-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/8c4a6ae2/attachment-0001.html>
